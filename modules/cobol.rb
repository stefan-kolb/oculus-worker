# COBOL
class Cobol
  attr_reader :name, :description

  def initialize
    @name = 'COBOL'
    @description = ''
  end

  def latest_stable
    '2014'
  end

  def latest_unstable
    'Not supported'
  end

  def versions
    %w(60 61 63 65 68 74 80 85 89 93 97 2002 2014)
  end
end
