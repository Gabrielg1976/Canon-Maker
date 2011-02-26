=begin 
Concept and Design by Gabriel Garrod (Email: GDGSoftwaredesigns@gmail.com or facebook.com/alphacore)

Last Updated: 01/27/2011 => Number of Lines: 345 lines => File Size: 11,589(k) at 12:22am
Current Update: 02/27/2011 => Number of lines: 345  => File Size: 11,589(k) at  12:22 am

Generates a Composition based of canon theories and concepts by randomly 
choosing one of the 54 scales (read the README.txt )

Based on the theory behind a cannon where each melody is a variation rooted in the orginal melody  

Current Features 

Generates the following 

melody
retrograde
octave splatter
Aug and Dim 
arp system
two note interval channel

rythm building system ( very rough prototype working ) 

=end

require 'rubygems'
require 'midilib'

# Scale Library 54 Total 
begin 
chromatic=[0,1,2,3,4,5,6,7,8,9,10,11,12] # C Db D Eb E F Gb G Ab A  Bb B  C
spanish_8_tone=[0,1,3,4,5,6,8,10,12]# C Db Eb E F Gb Ab Bb C
flamenco=[0,1,3,4,5,7,8,10,12]# C Db Eb E F G Ab Bb C
symmetrical=[0,1,3,4,6,7,9,10,12]# C Db Eb E Gb G A Bb C
diminished=[0,2,3,5,6,8,9,11,12]# C D Eb F Gb Ab A B C
whole_tone=[0,2,3,6,8,10,12]# C D E Gb Ab Bb C
augmented=[0,3,4,7,8,12]# C Eb E G Ab  C
three_semitone=[0,3,6,9,12]# C Eb Gb A C
four_semitone=[0,4,8,12]# C E Ab C
ultra_locrian=[0,1,3,6,8,9,12]# C Db Eb E Gb Ab A C
super_locrian=[0,1,3,4,6,8,10,12]# C Db Eb E Gb Ab Bb C
indian_ish=[0,1,3,4,7,8,10,12]# C Db Eb E G Ab Bb C
locrian=[0,1,3,5,6,8,10,12]# C Db Eb F Gb Ab Bb C
phrygian=[0,1,3,5,7,8,10,12]# C Db Eb F G  Ab Bb C
neapolitan_min=[0,1,3,5,7,8,11,12]#  C Db Eb F G Ab B C
javanese=[0,1,3,5,7,9,10,12]# C Db Eb F G A Bb C
neapolitan_maj=[0,1,3,7,9,9,11,12]#  C Db Eb F G A B C
todi=[0,1,3,6,7,8,11,12]# C Db Eb Gb G Ab B C
persian=[0,1,4,5,8,10,11,12]# C Db E F Gb Ab B C
oriental=[0,1,4,5,6,9,10,12]# C Db E F Gb A Bb C
maj_phryg=[0,1,4,5,6,8,10,12]# C Db E F G Ab Bb C
double_harmonic=[0,1,4,5,8,11,12]# C Db E F G Ab B C
marva=[0,1,4,6,7,9,11,12]# C Db E Gb G A B C
enigmatic=[0,1,4,6,8,10,11,12]# C Db E Gb Ab Bb B C
locrian_natural=[0,2,3,5,6,8,10,12]# C D Eb F Gb Ab Bb C
minor=[0,2,3,5,7,8,10,12]# (natural)C D Eb F G Ab Bb C
harmonic_minor=[0,2,3,5,7,8,11,12]# C D Eb F G Ab B C
dorian=[0,2,3,5,7,9,10,12]# C D Eb F G A Bb C
melodic_minor=[0,2,3,5,7,9,11,12]# C D Eb F G A B C
hungarian_gypsy =[0,2,3,6,7,8,10,12]# C D Eb Gb G Ab Bb C
hungarian_minor=[0,2,3,6,7,8,11,12]# C D Eb Gb G Ab B C
romanian=[0,2,3,6,7,9,10,12]# C D Eb Gb G A Bb C
maj_locrian=[0,2,4,5,6,8,10,12]# C  D  E  F  Gb Ab Bb C
hindu=[0,2,4,5,7,8,10,12]# C  D  E  F  G  Ab Bb C
ethiopian=[0,2,4,5,7,8,10,11,12]# C  D  E  F  G  Ab B  C
mixolydian=[0,2,4,5,7,9,10,12]# C  D  E  F  G  A  Bb C
major=[0,2,4,5,7,9,11,12]# C  D  E  F  G  A  B  C
mixolydian_aug=[0,2,4,5,8,10,12]# C  D  E  F  Ab A  Bb C
harmonic_major=[0,2,4,5,8,9,11,12]# C  D  E  F  Ab A  B  C  
lydian_min=[0,2,4,6,7,8,10,12]# C  D  E  Gb G  Ab Bb C  
lydian_dominant=[0,2,4,6,9,10,12]#C  D  E  Gb G  A  Bb C
lydian=[0,2,4,6,7,9,11,12]# C  D  E  Gb G  A  B  C 
lydian_aug=[0,2,4,6,8,9,10,12]# C  D  E  Gb Ab A  Bb C  
leading_whole_tone=[0,2,4,6,8,10,11,12]#   C  D  E  Gb Ab Bb B  C 
bluesy=[0,3,4,5,7,9,10,12]# C  Eb E  F  G  A  Bb C  
hungarian_major=[0,3,4,6,7,9,10,12]# C  Eb E  Gb G  A  Bb C 
pelog=[0,1,3,7,10,12]# C  Db Eb G  Bb C  
iwato=[0,1,5,6,10,12]# C  Db F  Gb Bb C 
japanese=[0,1,5,7,8,12]# C  Db F  G  Ab C 
hirajoshi=[0,2,3,7,8,12]# C  D  Eb G  Ab C
pentatonic_major=[0,2,4,7,9,12]# C  D  E  G  A  C  
egyptian=[0,2,5,7,10,12]# C  D  F  G  Bb C  
pentatonic_minor=[0,3,5,7,10,12]# C  Eb F  G  Bb C  
chinese=[0,4,6,7,11,12]# C  E  Gb G  B  C
end

scale_num=0

class TimedTrack < MIDI::Track
  
	  MIDDLE_C = 60
	  @@channel_counter=0
	  interval=[]

	  def initialize(number, song)
	    super(number)
	    @sequence = song
	    @time = 0
	    @channel = @@channel_counter
	    @@channel_counter += 1
	  end

	  # Tell this track's channel to use the given instrument, and
	  # also set the track's instrument display name.
	  def instrument=(instrument)
	    @events <<  
      MIDI::ProgramChange.new(@channel, instrument)
	    super(MIDI::GM_PATCH_NAMES[instrument])
	  end

	  # Add one or more notes to sound simultaneously. Increments the per-track
	  # timer so that subsequent notes will sound after this one finishes.
	  def add_notes(offsets, velocity=127, duration='quarter')
	    offsets = [offsets] unless offsets.respond_to? :each
	    offsets.each do |offset|
	      event(MIDI::NoteOnEvent.new(@channel, MIDDLE_C + offset, velocity))
	    end
	    @time += @sequence.note_to_delta(duration)
	    offsets.each do |offset|
	      event(MIDI::NoteOffEvent.new(@channel, MIDDLE_C + offset, velocity))
	    end
	    recalc_delta_from_times
	  end
	  
	  private

	  def event(event)
	    @events << event
	   event.time_from_start = @time
	  end
end

count=0

# sets the number of compositions generated..
1.times do

begin
 count += 1
 aug_dim_is=""
 up_down_is=""
 up_down_num = rand(2)+1
 aug_dim_num = rand(2)+1
 puts "The Composition is Generating.....\n"  
 tempo=rand(80)+55
 scale_num = rand(54)
end

# duration system 
begin
# This can be taken all the way to 128th
dur=["half","quarter","8th","16th"] ; dur_ex=["whole","32nd"]
# creates a octave range -2 octaves & +2 octaves from middle C 
oct_range=[-24,-12,0,12,24]
end

scale_name=""

if scale_num == 1
  interval = chromatic ; scale_name = "chromatic" 
 elsif scale_num == 2
  interval = spanish_8_tone ; scale_name = "spanish 8 tone" 
 elsif scale_num == 3 
  interval = flamenco ; scale_name = "flamenco" 
 elsif scale_num == 4 
  interval = symmetrical ; scale_name = "symetrical" 
 elsif scale_num == 5 
  interval = diminished ; scale_name = "diminished" 
 elsif scale_num == 6 
  interval = whole_tone ; scale_name = "whole tone" 
 elsif scale_num == 7
  interval = augmented ; scale_name = "augmented" 
 elsif scale_num == 8
  interval = three_semitone ; scale_name = "three semitone" 
 elsif scale_num == 9
  interval = four_semitone ; scale_name = "four semitone" 
 elsif scale_num == 10
  interval = ultra_locrian ; scale_name = "ultra locrian" 
 elsif scale_num == 11
  interval = super_locrian ; scale_name = "super locrian" 
 elsif scale_num == 12
  interval = indian_ish ; scale_name = "indianish" 
 elsif scale_num == 13
  interval = locrian ; scale_name = "locrian"
 elsif scale_num == 14
  interval = phrygian ; scale_name = "phrygian" 
 elsif scale_num == 15
  interval = neapolitan_min ; scale_name = "neapolitian minor" 
 elsif scale_num == 16
  interval = javanese ; scale_name = "javanese" 
 elsif scale_num == 17
  interval = neapolitan_maj ; scale_name = "neapolitian major" 
 elsif scale_num == 18
  interval = todi ; scale_name = "todi" 
 elsif scale_num == 19
  interval = persian ; scale_name = "persian"
 elsif scale_num == 20
  interval = oriental ; scale_name = "oriental"
 elsif scale_num == 21
  interval = maj_phryg ; scale_name = "major phrygian "
 elsif scale_num == 22
  interval = double_harmonic ; scale_name = "double harmonic" 
 elsif scale_num == 23
  interval = marva ; scale_name = "marva"
 elsif scale_num == 24 
  interval = enigmatic ; scale_name = "enigmatic"
 elsif scale_num == 25 
  interval = locrian_natural ; scale_name = "locrian natural "
 elsif scale_num == 26
  interval = minor ; scale_name = "minor " 
 elsif scale_num == 27
  interval = harmonic_minor ; scale_name = "harmonic minor "
 elsif scale_num == 28 
  interval = dorian ; scale_name = "dorian " 
 elsif scale_num == 29
  interval = melodic_minor ; scale_name = "melodic minor "
 elsif scale_num == 30
  interval = hungarian_gypsy ; scale_name = "hungarian gypsy"
 elsif scale_num == 31
  interval = hungarian_minor ; scale_name = "hungarian minor"
 elsif scale_num == 32 
  interval = romanian ; scale_name = "romanian" 
 elsif scale_num == 33
  interval = maj_locrian ; scale_name = "major locrian"
 elsif scale_num == 34
  interval = hindu ; scale_name = "hindu" 
 elsif scale_num == 35
  interval = ethiopian ; scale_name = "ethiopian"
 elsif scale_num == 36 
  interval = mixolydian ; scale_name = "mixloydian"
 elsif scale_num == 37 
  interval = major ; scale_name = "major"
 elsif scale_num == 38
  interval = mixolydian_aug ; scale_name = "mixolydian aug"
 elsif scale_num == 39
  interval = harmonic_major ; scale_name = "harmonic major" 
 elsif scale_num == 40
  interval = lydian_min ; scale_name = "lydian minor"
 elsif scale_num == 41  
  interval = lydian_dominant ; scale_name = "lydian dominant"
 elsif scale_num == 42
  interval = lydian ; scale_name = "lydian" 
 elsif scale_num == 43
  interval = lydian_aug ; scale_name = "lydian aug"
 elsif scale_num == 44 
  interval = leading_whole_tone ; scale_name = "leading whole tone"
 elsif scale_num == 45 
  interval = bluesy ; scale_name = "bluesy"   
 elsif scale_num == 46
  interval = hungarian_major ; scale_name = "hungarian major"
 elsif scale_num == 47  
  interval = pelog ; scale_name = "pelog"   
 elsif scale_num == 48
  interval = iwato ; scale_name = "iwato"  
 elsif scale_num == 49
  interval = japanese ; scale_name = "japanese"
 elsif scale_num == 50
  interval = hirajoshi ; scale_name = "hirajoshi"
 elsif scale_num == 51
  interval = pentatonic_major ; scale_name = "pentatonic major"
 elsif scale_num == 52  
  interval = egyptian ; scale_name = "egyptian" 
 elsif scale_num == 53 
  interval = pentatonic_minor ; scale_name = "pentatonic minor"
 elsif scale_num == 54  
  interval = chinese ; scale_name = "chinese"
 else
  interval = major ; scale_name = "Major"
end

# :::: => Creates the Song object <= ::::
begin
 song = MIDI::Sequence.new
 # How the tracks are created you can add as many has you like manual here 
 song.tracks << (melody = TimedTrack.new(0, song ))
 song.tracks <<(retrograde = TimedTrack.new(1,song))
 song.tracks <<(aug_dim = TimedTrack.new(2,song))
 song.tracks <<(bass = TimedTrack.new(3,song))
 song.tracks <<(oct_splatter = TimedTrack.new(4,song))
 song.tracks <<(arp = TimedTrack.new(5,song))
 song.tracks <<(ry1 = TimedTrack.new(6,song))
 song.tracks <<(tn = TimedTrack.new(7,song))
 # Chooses the channels Instrument
 melody.instrument = 00 
 arp.instrument = 00 
 ry1.instrument = 00
 tn.instrument = 00
 retrograde.instrument = 00
 aug_dim.instrument = 00
 bass.instrument = 00 
 oct_splatter.instrument = 00
 # Names the tracks
 melody.name = "Melody"
 arp.name = "ARP"
 ry1.name = "rhythm"
 tn.name = "rhythm tester"
 retrograde.name = "Retrograde"
 aug_dim.name = "Varation durtion"
 bass.name= "bass"
 oct_splatter.name ="oct splatter"
 melody.events << MIDI::Tempo.new(MIDI::Tempo.bpm_to_mpq(tempo))
end 

# Arp System 
begin
maj_i_arp=[]
min_ii_arp=[]
min_iii_arp=[]
maj_iv_arp=[]
maj_v_arp=[]
min_vi_arp=[]
min_vii_arp=[]

# Builds each of the chords based on the scale choosen by user.
# major i
maj_i_arp << interval[0] << interval[2] << interval[4]
# minor ii
min_ii_arp << interval[1] << interval[3] << interval[5]
# minor iii
min_iii_arp << interval[2]<< interval[4] << interval[6]
# major iv
maj_iv_arp << interval[3] << interval[5] << interval[0]
# major v
maj_v_arp << interval[4] << interval[6] << interval[1]
# minor vi 
min_vi_arp << interval[5] << interval[0] << interval[2]
# minor vii
min_vii_arp << interval[6] << interval[1] << interval[3]
end

# :::: => Creates the Musical Composition <= ::::
begin
melody_notes=[];retrograde_notes=[]

# arp system example 

2.times do
 2.times do
  arp.add_notes(maj_i_arp[rand(maj_i_arp.size)],rand(77) + 50,"quarter")
 end
 2.times do
  arp.add_notes(maj_v_arp[rand(maj_v_arp.size)],rand(77) + 50,"half")
 end
end

# rythmn pattern test based on a 4/4 beat

begin
4.times do

1.times do
 ry1.add_notes(interval[rand(interval.size)],rand(77) + 50,"quarter")
end

2.times do
 ry1.add_notes(interval[rand(interval.size)],rand(77) + 50,"8th")
end

1.times do
 ry1.add_notes(interval[rand(interval.size)],rand(77) + 50,"half")
end
end

end

4.times do
 melody_notes << interval[rand(interval.size)]
 # melody_notes << 0
end
  
melody_notes.each do |x|
  
melody.add_notes(x ,rand(127)+50,d=dur[rand(dur.size)])
bass.add_notes(x,rand(77)+50,"whole")


2.times do
 tn.add_notes([melody_notes[rand(melody_notes.size)],x].collect,rand(98)+30,"quarter") 
end

2.times do
 oct_splatter.add_notes(x+oct_range[rand(oct_range.size)],rand(127)+50,"quarter")
end

# randomly chooses either aug or dim

if aug_dim_num==1
  aug_dim_is="Aug"
# aug logic !!! Works !!!!
r=""
if d == dur[0]
 r = dur_ex[0]
 aug_dim.add_notes(x,rand(127)+50,r)
elsif d == dur[1]
 r = dur[0]
 aug_dim.add_notes(x,rand(127)+50,r)
elsif d == dur[2]
 r = dur[1]
 aug_dim.add_notes(x,rand(127)+50,r)
elsif d == dur[3]
 r = dur[2]
 aug_dim.add_notes(x,rand(127)+50,r)
end
end

if aug_dim_num == 2
aug_dim_is="dim"
# dim logic 
r2=""
if d == dur[0]
   r2 = dur[1]
   aug_dim.add_notes(x,rand(127)+50,r2)
 elsif d == dur[1]
   r2 = dur[2]
   aug_dim.add_notes(x,rand(127)+50,r2)
 elsif d == dur[2]
   r2 = dur[3]
   aug_dim.add_notes(x,rand(127)+50,r2)
 elsif d == dur[3]
   r2 = dur_ex[1]
   aug_dim.add_notes(x,rand(127)+50,r2)
end

end

end
 
# This is the retrograde channel logic
 retrograde_notes = melody_notes.reverse
 
 2.times do
  retrograde_notes.each do |x|
  retrograde.add_notes(x ,rand(127)+50,dur[rand(dur.size)])
  end
 end
end
# Generates the midi file.
open(song_title ="The Electrophonic #{scale_name} scaled Opus #{count}"+".mid",'w') { |f| song.write(f) }
puts "Compositonal Title: #{song_title}"
puts "The Tempo is #{tempo}\n\n"+"Composition Generation Complete!"
end