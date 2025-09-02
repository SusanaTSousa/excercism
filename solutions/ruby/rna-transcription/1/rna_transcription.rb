=begin
Write your code for the 'Rna Transcription' exercise in this file. Make the tests in
`rna_transcription_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/rna-transcription` directory.
=end

class Complement
  
  COMPLEMENT_DICT = { "G": "C", "C": "G", "T": "A", "A": "U" }.freeze
  
  def self.of_dna(dna_strand)
    rna_strand = ""
    dna_strand.each_char do |c|
      rna_strand << COMPLEMENT_DICT[c.to_sym]
    end
    rna_strand
  end
  
end
