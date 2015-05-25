library(ggvis)
library(dplyr)

load('WIRDS/2014-2015/datasets/gospodarstwa.rda')


# histogramy -----------------

gosp %>%
  ggvis(x = ~wydg)

gosp %>%
  ggvis(x = ~wydg) %>%
  layer_histograms()

ggvis(data = gosp, x= ~wydg)


# wykresy słupkowe ---------------

gosp %>%
  ggvis(x = ~ as.factor(klm))


# skala logarytmiczna ------

gosp %>%
  ggvis(x = ~ log(wydg))

gosp %>%
  mutate(wydg_log = log(wydg)) %>%
  ggvis(x = ~wydg_log)

gosp %>%
  ggvis(x = ~wydg) %>%
  scale_numeric('x', trans = 'log')

gosp %>%
  na.omit() %>%
  group_by(klm) %>%
  ggvis(x = ~ log(wydg), 
        fill = ~as.factor(klm)) %>%
  layer_densities()


# wykres rozrzutu -------------

gosp %>%
  slice(1:1000) %>%
  ggvis(x = ~dochg, y= ~wydg) %>%
  layer_model_predictions(model = 'lm') %>%
  layer_points(stroke := 'black',
               fill := 'red')

gosp %>%
  slice(1:1000) %>%
  group_by(klm) %>%
  ggvis(x = ~dochg, y= ~wydg, stroke= ~as.factor(klm)) %>%
  layer_model_predictions(model = 'lm') %>%
  layer_points()


### agregacja

gosp %>%
  group_by(woj) %>%
  summarise(doch_med = median(dochg,na.rm=T),
            wyd_med = median(wydg,na.rm=T)) %>%
  ungroup() %>%
  ggvis(x = ~doch_med,
        y  = ~wyd_med) %>%
  layer_points() %>%
  add_tooltip( function(x) {
    paste('Wydatki: ', x$wyd_med, '<br />', 
          'Dochody: ', x$doch_med, '<br />', 
          'Województwo: ', x$woj, '<br />')
  }, 'click')


### dodajemy możliwosć zmiany wielkosci puntu

gosp %>%
  group_by(woj) %>%
  summarise(doch_med = median(dochg,na.rm=T),
            wyd_med = median(wydg,na.rm=T)) %>%
  ggvis(x = ~doch_med,
        y  = ~wyd_med) %>%
  layer_points(size := input_slider(min = 1,
                                    max = 50,
                                    step=1)) 


gosp %>%
  slice(1:1000) %>%
  ggvis(x = ~dochg, y = ~wydg) %>%
  layer_points(opacity := input_slider(min=0,
                                       max=1,
                                       step=0.01))




