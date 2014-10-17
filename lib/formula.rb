class Formula

  INNER_PARENTHESIS_REGEX=/^([^\(]*)\((.*)\)([^\)]*)$/ #Starts with anything but (, then ( then anything then )
  # then ends with anything but )

  def initialize(args={})
    @references = args[:references]
    @size = args[:boilers].count
  end

  def translate(expression)
    expression=expression[2..-1] #Removing #=
    sums = expression.split
  end

  def expression_to_vector(vector, exp, factor)
    data = exp.split('*')
    if data.count is 2
      new_factor = data[0].to_f * factor
      new_exp = data[1]
    else
      new_exp = data[0]
    end
    new_exp=new_exp[1..-2] if new_exp[0] == '(' #canonical view, no parenthesis
    inner_exp_match = INNER_PARENTHESIS_REGEX.match new_exp
    if inner_exp_match
      new_exp=inner_exp_match[1] + inner_exp_match[3]
      post_processing = inner_exp_match[2]
    end

  end

end