require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'sequence_window_descriptor'

describe "SequenceWindowDescriptor" do
  it 'test_first' do
    desc = Bio::SequenceWindowDescriptor.new
    desc.calculate(Bio::Sequence::AA.new('GGY'), 2)
    desc.maximum_counts[:gly].should == 2
    desc.maximum_sequences[:gly].should == 'GG'
  end

  it 'test_not_first' do
    desc = Bio::SequenceWindowDescriptor.new
    desc.calculate(Bio::Sequence::AA.new('GGYYYGGYGY'), 4)
    desc.maximum_counts[:gly].should == 3
    desc.maximum_sequences[:gly].should == 'GGYG'
  end

  it 'test_not_big_enough' do
    desc = Bio::SequenceWindowDescriptor.new
    desc.calculate(Bio::Sequence::AA.new('GG'), 4)
    desc.maximum_counts[:gly].should == 0
    desc.maximum_sequences[:gly].should == ''
  end
end
