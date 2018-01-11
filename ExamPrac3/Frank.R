#This is how you search for the book #!!!!!!!
#Use packages dplyr, gutenbergr, ggplot2, stringr, tidytext 
gutenberg_works(str_detect(title,'Frankenstein'))

#head(frankenstein) in the console shows you the dataframe is there
frankenstein<-gutenberg_download(84)

#Remove that column from the dataframe
frankenstein_words$gutenberg_id<-NULL

frankenstein_words<-unnest_tokens(frankenstein,word,text)

afinn<-get_sentiments('afinn')
View(afinn)

#dim(frankenstein_words) in the console tells you how many words there are!
frankenstein_words$word_number<-1:75175

#Add the afinn scores that correlate to the words in the dataframe
frankenstein_words<-inner_join(frankenstein_words,afinn)

#Add new column to the dataframe with accumulated sums for affin word scores
frankenstein_words$acc_sent<-cumsum(frankenstein_words$score)

ggplot()+
  geom_line(data=frankenstein_words,aes(x=word_number,y=acc_sent))
  ggtitle('Accumulated Sentiment for Frankenstein')

