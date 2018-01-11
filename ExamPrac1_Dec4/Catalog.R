#tidy text, dplyr, ggplot2
catalog_scan<-scan('mercyhurst.txt',what=character(),sep='\n')
catalog_lines<-data_frame(line=1:24066,text=catalog_scan)
catalog_words<-unnest_tokens(catalog_lines,word,text)

affin<-get_sentiments('afinn')
catalog_words<-inner_join(catalog_words,affin)

#This shows in groups of 80 (wanted 300 data points = 24000 div. by 80)
catalog_words<-catalog_words%>%
  mutate(group=line%/%80)

#This sums up the scores by group numbers - Group 0 = 4, 1 = 5, etc.
catalog_groups<-catalog_words%>%
  group_by(group)%>%
  summarize(sentiment=sum(score))

ggplot()+
  geom_col(data=catalog_groups,aes(x=group,y=sentiment))

