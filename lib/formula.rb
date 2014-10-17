require_relative 'boiler'

class Formula

  INNER_PARENTHESIS_REGEX=/(((\d+,)?\d+)\*)?(-?)(\(.*\))/ #search for 2*(...) or +(...) or -(...)
  # then ends with anything but )

  def initialize(args={})
    @references = args[:references]
  end

  def translate(exp)
    exp=exp[2..-1] #Removing #=
    hash = {}
    factor = 1.0
    types = form_types(exp)
    expression_to_vector(hash,factor,exp, types)
  end

  def form_types(exp)
    types = []
    match = /!(O)/.match exp
    if match
      types=Boiler::Types
      types.delete('K') if /!(K)/.match(exp)
      types.delete('L') if /!(L)/.match(exp)
      types.delete('M') if /!(M)/.match(exp)
      types.delete('N') if /!(N)/.match(exp)
    else
      types.push('K') if /!(K)/.match(exp)
      types.push('L') if /!(L)/.match(exp)
      types.push('M') if /!(M)/.match(exp)
      types.push('N') if /!(N)/.match(exp)
    end
    types.sort
  end

  def expression_to_vector(hash, factor, exp, types)
    exp=exp[1..-2] if exp[0] == '(' #canonical view, no parenthesis
    return if exp=='' or exp.nil?
    inner_exp_match = INNER_PARENTHESIS_REGEX.match exp
    if inner_exp_match
      post_processing_exp=inner_exp_match[5]
      post_processing_factor = inner_exp_match[2].nil? ? factor : factor * inner_exp_match[2].sub(',','.').to_f
      expression_to_vector(hash, post_processing_factor, post_processing_exp, types)
      exp = inner_exp_match.pre_match + inner_exp_match.post_match
    end
    lexems = exp.split('+')
    lexems.each do |lexem|
      update_vector_for_lexem(hash, factor, lexem, types) unless lexem.empty?
    end
    hash
  end

  def lexem_to_reference(lexem)
    match = /!\D+/.match lexem
    raise "Undefined lexem structure #{lexem}" unless match
    raise "Undefined lexem structure #{lexem}" unless match.pre_match and match.post_match
    match.pre_match+'!'+match.post_match
  end

  def update_vector_for_lexem(hash, factor, lexem, types)
    match = /(((\d+,)?\d+)\*)?(.*)/.match lexem
    if match[1]
      number = match[2].sub(',','.')
      factor *= number.to_f
    end
    lexem = match[4]
    ref = lexem_to_reference lexem
    types.each do |type|
      id = @references.get_id(ref) + "&#{type}"
      hash[id]||=0
      hash[id]+=factor
    end
  end

end