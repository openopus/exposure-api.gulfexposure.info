# randexp.rb: -*- Ruby -*-  DESCRIPTIVE TEXT.
# 
#  Copyright (c) 2017 Brian J. Fox
#  Author: Brian J. Fox (bfox@opuslogica.com) Sat Jul  8 12:59:57 2017.
Randexp::Dictionary.class_variable_set(:@@words, File.read(Rails.root + "config/codename-words.txt").split)
