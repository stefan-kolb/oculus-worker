# DOTNET
# Source: http://msdn.microsoft.com/en-us/library/bb822049%28v=vs.110%29.aspx
class Dotnet
  attr_reader :name, :description

  def initialize
    @name = 'Dotnet'
    @description = ''
  end

  def latest_stable
    '4.5.2'
  end

  def latest_unstable
    'Not supported'
  end

  def versions
    %w[4.5.2 4.5.1 4.5 4 3.5 3. 2.0 1.1 1.0]
  end
end
