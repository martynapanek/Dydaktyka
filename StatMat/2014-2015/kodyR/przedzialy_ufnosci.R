### generowanie 

library(ggplot2)

gen_confint_plot <- function(m=2500,
                             s=250,
                             N=1000,
                             n=50,
                             r=100) {
  
  if (n>=N) {
    stop('Sample size is higher or equal to population size',
         call.=F)
  }
  
  
  require(ggplot2)
  doch <- rnorm(n = N,
                mean = m,
                sd = s)
  m_true <- mean(doch)
  
  wynik <- list()
  
  for (i in 1:r) {
    ids <- sample(x = 1:N,size = n)
    wyb <- doch[ids]
    w <- c(mean(wyb),
           as.numeric(t.test(wyb)$conf.int))
    wynik[[i]] <- w
  }
  
  
  wynik <- do.call('rbind',wynik)
  wynik <- as.data.frame(wynik)
  names(wynik) <- c('Mean','LB','HB')
  wynik$ID <- seq_len(r)
  wynik$col <- with(wynik, 
                    ifelse( LB < m_true & 
                              m_true < HB,'yellow','blue'))
  p <- ggplot(data=wynik) +
    geom_errorbar(aes(ymin=LB,ymax=HB,x=ID,colour=col)) +
    geom_point(aes(x=ID,y=Mean,colour=col)) + 
    geom_hline(y=mean(doch)) + 
    coord_flip() +
    theme_bw() +
    theme(legend.position='none') +
    xlab('Numer powtórzenia') +
    ylab('Średnia z próby')
  
  return(p)
  
}

set.seed(123)

# Zakładamy, że zmienna losowa X ~ N(m,s)
# m - średnia w populacji 
# s - odchylenie std w populacji
# N - wielkość populacji
# n - wielkość próby
# r - liczba powtórzeń

gen_confint_plot(r=50,n = 100)



