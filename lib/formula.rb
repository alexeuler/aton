class Formula

  INNER_PARENTHESIS_REGEX=/((\d+)\*)?(-?)(\(.*\))/ #search for 2*(...) or +(...) or -(...)
  # then ends with anything but )

  def initialize(args={})
    @references = args[:references]
  end

  def translate(exp)
    exp=exp[2..-1] #Removing #=
    hash = {}
    factor = 1
    expression_to_vector(hash,factor,exp)
  end

  def expression_to_vector(hash, factor, exp)
    exp=exp[1..-2] if exp[0] == '(' #canonical view, no parenthesis
    return if exp=='' or exp.nil?
    inner_exp_match = INNER_PARENTHESIS_REGEX.match exp
    if inner_exp_match
      post_processing_exp=inner_exp_match[4]
      post_processing_factor = inner_exp_match[2].nil? ? factor : factor * inner_exp_match[2].to_i
      expression_to_vector(hash, post_processing_factor, post_processing_exp)
      exp = inner_exp_match.pre_match + inner_exp_match.post_match
    end
    lexems = exp.split('+')
    lexems.each do |lexem|
      update_vector_for_lexem(hash, factor, lexem)
    end
    hash
  end

  def lexem_to_reference(lexem)
    match = /!\D+/.match lexem
    raise "Undefined lexem structure #{lexem}" unless match.pre_match and match.post_match
    match.pre_match+'!'+match.post_match
  end

  def update_vector_for_lexem(hash, factor, lexem)
    ref = lexem_to_reference lexem
    id = @references.get_id(ref)
    hash[id]||=0
    hash[id]+=factor
  end

end