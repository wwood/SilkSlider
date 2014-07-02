require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'bio-commandeer'
require 'pry'

describe "SilkSlider" do
  PATH_TO_SCRIPT = File.join(File.dirname(__FILE__),'..','bin','silk_slider')

  it "should work with a positive" do
    # This is a malarial protein known to have a signal peptide
    acp = 'MKILLLCIIFLYYVNAFKNTQKDGVSLQILKKKRSNQVNFLNRKNDYNLIKNKNPSSSLKSTFDDIKKIISKQLSVEEDK'+
      'IQMNSNFTKDLGADSLDLVELIMALEEKFNVTISDQDALKINTVQDAIDYIEKNNKQ'
    acp_gly = acp + 'G'*30
    fasta = [
      '>positive',
      acp_gly
      ].join("\n")+"\n"
    command = "#{PATH_TO_SCRIPT} --quiet /dev/stdin"
    res = Bio::Commandeer.run command, :stdin => fasta
    res.should == fasta
  end

  it "should work with a negative" do
    # This is a malarial protein known to have a signal peptide
    acp = 'MKILLLCIIFLYYVNAFKNTQKDGVSLQILKKKRSNQVNFLNRKNDYNLIKNKNPSSSLKSTFDDIKKIISKQLSVEEDK'+
      'IQMNSNFTKDLGADSLDLVELIMALEEKFNVTISDQDALKINTVQDAIDYIEKNNKQ'
    fasta = [
      '>positive',
      acp
      ].join("\n")+"\n"
    command = "#{PATH_TO_SCRIPT} --quiet /dev/stdin"
    res = Bio::Commandeer.run command, :stdin => fasta
    res.should == ''
  end

  it 'should screen out non-signal peptide proteins' do
    # This is a malarial protein known to have a signal peptide
    acp_without_start_sp = 'SLQILKKKRSNQVNFLNRKNDYNLIKNKNPSSSLKSTFDDIKKIISKQLSVEEDK'+
      'IQMNSNFTKDLGADSLDLVELIMALEEKFNVTISDQDALKINTVQDAIDYIEKNNKQ'
    acp_gly = acp_without_start_sp + 'G'*30
    fasta = [
      '>positive',
      acp_gly
      ].join("\n")+"\n"
    command = "#{PATH_TO_SCRIPT} --quiet /dev/stdin"
    res = Bio::Commandeer.run command, :stdin => fasta
    res.should == ''
  end

  it 'should screen out TMD proteins' do
    # This is a malarial protein known to have several TMDs (but no SP)
    pfcrt = 'MKFASKKNNQKNSSKNDERYRELDNLVQEGNGSRLGGGSCLGKCAHVFKLIFKEIKDNIFIYILSIIYLSVCVMNKIFAK
RTLNKIGNYSFVTSETHNFICMIMFFIVYSLFGNKKGNSKERHRSFNLQFFAISMLDACSVILAFIGLTRTTGNIQSFVL
QLSIPINMFFCFLILRYRYHLYNYLGAVIIVVTIALVEMKLSFETQEENSIIFNLVLISALIPVCFSNMTREIVFKKYKI
DILRLNAMVSFFQLFTSCLILPVYTLPFLKQLHLPYNEIWTNIKNGFACLFLGRNTVVENCGLGMAKLCDDCDGAWKTFA
LFSFFNICDNLITSYIIDKFSTMTYTIVSCIQGPAIAIAYYFKFLAGDVVREPRLLDFVTLFGYLFGSIIYRVGNIILER
KKMRNEENEDSEGELTNVDSIITQ'
    acp = 'MKILLLCIIFLYYVNAFKNTQKDGVSLQILKKKRSNQVNFLNRKNDYNLIKNKNPSSSLKSTFDDIKKIISKQLSVEEDK'+
      'IQMNSNFTKDLGADSLDLVELIMALEEKFNVTISDQDALKINTVQDAIDYIEKNNKQ'
    acp_pfcrt_gly = acp + pfcrt + 'G'*30 #put a SP on the start of a TMD protein, then a passing window
    fasta = [
      '>positive',
      acp_pfcrt_gly
      ].join("\n")+"\n"
    command = "#{PATH_TO_SCRIPT} --quiet /dev/stdin"
    res = Bio::Commandeer.run command, :stdin => fasta
    res.should == ''
  end

  it 'should work with multiple sequences' do
    acp = 'MKILLLCIIFLYYVNAFKNTQKDGVSLQILKKKRSNQVNFLNRKNDYNLIKNKNPSSSLKSTFDDIKKIISKQLSVEEDK'+
      'IQMNSNFTKDLGADSLDLVELIMALEEKFNVTISDQDALKINTVQDAIDYIEKNNKQ'
    acp_without_start_sp = 'SLQILKKKRSNQVNFLNRKNDYNLIKNKNPSSSLKSTFDDIKKIISKQLSVEEDK'+
      'IQMNSNFTKDLGADSLDLVELIMALEEKFNVTISDQDALKINTVQDAIDYIEKNNKQ'

    fasta = [
      '>positive1',
      acp + 'G'*30,
      '>neg',
      acp_without_start_sp,
      '>pos2 yeh',
      acp + 'G'*25,
      ].join("\n")+"\n"
    command = "#{PATH_TO_SCRIPT} --quiet /dev/stdin"
    res = Bio::Commandeer.run command, :stdin => fasta
    res.should == [
      '>positive1',
      acp + 'G'*30,
      '>pos2 yeh',
      acp + 'G'*25,
      ].join("\n")+"\n"
  end

  it 'shoudl work with changed min gly' do
    acp = 'MKILLLCIIFLYYVNAFKNTQKDGVSLQILKKKRSNQVNFLNRKNDYNLIKNKNPSSSLKSTFDDIKKIISKQLSVEEDK'+
      'IQMNSNFTKDLGADSLDLVELIMALEEKFNVTISDQDALKINTVQDAIDYIEKNNKQ'
    fasta = [
      '>positive1',
      acp + 'G'*15,
      ].join("\n")+"\n"
    command = "#{PATH_TO_SCRIPT} --quiet /dev/stdin"
    res = Bio::Commandeer.run command, :stdin => fasta
    res.should == ''
    command = "#{PATH_TO_SCRIPT} --quiet /dev/stdin --min-glycines 5"
    res = Bio::Commandeer.run command, :stdin => fasta
    res.should == fasta
  end
end
