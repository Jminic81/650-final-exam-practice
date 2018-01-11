#Using packages:  dplyr, tidytext, tm (textmining), wordcloud

#Google Bruce Springsteen Born TO Run Album Lyrics.  Pasted lyrics into 
#separate text file tab = "Lyrics.txt".  Deleted song titles.  Created new file = 
#Rscript (this tab).

#Read each line, go to the next line when you get to the end of the line ('\n')

lines<-scan('Lyrics.txt', what=character(),sep='\n')
lines_df<-data_frame(line=1:292,text=lines)

#Unnest_tokens splits the lines into separate words. Specify output (word) and 
#input (text).

words_df<-lines_df%>%
  unnest_tokens(word,text)

#Remove stop_words = a, after, about, = mostly articles and prepositions
#Filter the words that are not equal (!) to stop words, in% = belongs to 

words_df<-words_df%>%
  filter(!(word %in% stop_words$word))

#Count and display the frequency of each word.

word_freq<-words_df%>%
  group_by(word)%>%
  summarize(count=n())

#Display the results in a wordcloud.  Keep running until you get one that you 
#like.  If there is an error message that some words will
#not fit so they won't be plotted, increase the size of
#the plot window.

wordcloud(word_freq$word,word_freq$count)

#Choose the number of colors from brewer palette Dark 2 (=4) to show in the 
#word cloud.  

wordcloud(word_freq$word,word_freq$count,colors=brewer.pal(3,'Dark2'))

