###############RAPORTY TABELARYCZNE W R###############

setwd("C:/Users/KS_MS/Desktop/FG/Zajêcia 2015/Wirds/Tabele")  
load('gospodarstwa.rda')
library(sjPlot)
# Zadanie 1
sjt.frq(gosp$klm)

# Zadanie 2

gosp$klm <- set_val_labels(gosp$klm, 
                      lab=c("500T+","200T-500T","100T-200T",
                        "20T-100T","- 20T","Wieœ"))

gosp$klm <- set_var_labels(gosp$klm, 
                          lab="Klasa wielkoœci miejscowoœci")

sjt.frq(gosp$klm,encoding="cp1250")

# Zadanie 3

sjt.frq(gosp$klm,variableLabels = "",
        encoding="cp1250",
        stringValue = "Klasa wielkoœci miejscowoœci",
        stringCount = "N",
        stringValidPerc = "% wa¿nych",
        showSummary = FALSE,
        stringPerc = '%',
        stringCumPerc = '% cum',
        stringMissingValue = 'Braki danych'
        )

# Zadanie 4

gosp$zut <- set_val_labels(gosp$zut, 
                           lab=c("Gospodarstwo pracowników",
                                 "Gospodarstwo pracowników u¿ytkuj¹cych gospodarstwo rolne",
                                 "Gospodarstwo rolników",
                                 "Gospodarstwo pracuj¹cych na w³asny rachunek poza gospodarstwem rolnym",
                                 "Gospodarstwo emerytów",
                                 "Gospodarstwo rencistów",
                                 "Gospodarstwo utrzymuj¹ce siê z niezarobkowowych Ÿróde³"))

gosp$zut <- set_var_labels(gosp$zut, 
                           lab="ród³o utrzymania")

sjt.frq(gosp$zut,variableLabels = "",
        encoding="cp1250",
        stringValue = "ród³o utrzymania",
        stringCount = "N",
        stringValidPerc = "% wa¿nych",
        showSummary = FALSE,
        stringPerc = '%',
        stringCumPerc = '% cum',
        stringMissingValue = 'Braki danych'
)

# Zadanie 5

sjt.xtab(gosp$zut,gosp$klm,encoding="cp1250")

# Zadanie 6

sjt.xtab(gosp$zut, 
         gosp$klm, 
         encoding="cp1250",
         showRowPerc = TRUE, 
         showCellPerc = TRUE, 
         showColPerc = TRUE,
         showLegend = FALSE,
         stringTotal = 'Ogó³em',
         showSummary = FALSE)

# Zadanie 7

gosp$d61 <- set_val_labels(gosp$d61, 
                           lab=c('Bardzo dobra',
                                 'Raczej dobra',
                                 'Przeciêtna',
                                 'Raczej z³a',
                                 'Z³a'))

gosp$d61 <- set_var_labels(gosp$d61, 
                           lab="Sytuacja materialna")


sjt.xtab(gosp$zut, 
         gosp$d61, 
         encoding='cp1250',
         showCellPerc = TRUE, 
         showLegend = FALSE,
         stringTotal = 'Ogó³em',
         showSummary = FALSE,
         highlightTotal = TRUE,
         tdcol.n = 'red',
         tdcol.cell = 'blue'
         )

# Zadanie 8

sjt.xtab(gosp$zut,gosp$d61,gosp$klm,
         showSummary = FALSE,
         encoding='cp1250',
         showLegend = FALSE,
         stringTotal = 'Ogó³em'
         )

# Zadanie 9
gosp$dochg <- set_var_labels(gosp$dochg, 
                           lab="Dochód")
gosp$wydg <- set_var_labels(gosp$wydg, 
                           lab="Wydatki")
gosp$los <- set_var_labels(gosp$los, 
                           lab="Liczba osób")

df <- data.frame(gosp$dochg,gosp$wydg,gosp$los)

sjt.corr(df,
         corMethod="pearson",
         encoding = "cp1250",
         title="Wspó³czynniki korelacji liniowej Pearsona",
        )

# Zadanie 10
sjt.corr(df,
         corMethod="pearson",
         encoding = "cp1250",
         pvaluesAsNumbers = TRUE,
         stringDiagonal=c(1,1,1)
)

# Zadanie 11

sjt.corr(df,
         corMethod="pearson",
         encoding = "cp1250",
         pvaluesAsNumbers = FALSE,
         stringDiagonal=c(1,1,1),
         val.rm=0.3
)

# Zadanie 12

sjt.corr(df,
         corMethod='spearman',
         encoding = 'cp1250',
         pvaluesAsNumbers = FALSE,
         stringDiagonal=c(1,1,1),
         triangle='upper'
)

# Zadanie 13

sjt.corr(df,
         corMethod='spearman',
         encoding = 'cp1250',
         pvaluesAsNumbers = FALSE,
         stringDiagonal=c(1,1,1),
         val.rm=0.4,
         CSS = list(css.valueremove = "color: #FF4040;")
)

# Zadanie 14

model1 <- lm(wydg~dochg,data=gosp)
sjt.lm(model1)

# Zadanie 15

model2 <- lm(wydg~los,data=gosp)

sjt.lm(model1,model2,
       stringObservations = 'Obserwacje',
       encoding = 'cp1250',
       stringIntercept = 'Wyraz wolny')

# Zadanie 16

model <- lm(wydg~dochg+los,data=gosp)

sjt.lm(model,
       stringObservations = 'Obserwacje',
       encoding = 'cp1250',
       stringIntercept = 'Wyraz wolny',
       showStdBeta = TRUE)

# Zadanie 17

gospodarstwa <- read_spss(path = "C:/Users/KS_MS/Desktop/FG/Zajêcia 2015/Wirds/Tabele w Sjplot/gosp.sav",  
                          enc = "cp1250",           
                          autoAttachVarLabels = TRUE)

view_spss(gospodarstwa,encoding = "cp1250")

labels.values <- get_val_labels(gospodarstwa)

labels.variables <- get_var_labels(gospodarstwa)

gospodarstwa <- set_val_labels(gospodarstwa, labels.values)

gospodarstwa <- set_var_labels(gospodarstwa, labels.variables)

sjt.frq(gospodarstwa$wojewodztwo,variableLabels = "",
        encoding="cp1250",
        stringValue = "Województwo",
        stringCount = "N",
        stringValidPerc = "% wa¿nych",
        showSummary = FALSE,
        stringPerc = '%',
        stringCumPerc = '% cum',
        stringMissingValue = 'Braki danych'
)

# Zadanie 18

sjt.df(gospodarstwa)

# Zadanie 19

sjt.df(gospodarstwa[,16:17])

# Zadanie 20

radio <- read_spss(path = "C:/Users/KS_MS/Desktop/FG/Zajêcia 2015/Wirds/Tabele w Sjplot/radio.sav",  
                          enc = "cp1250",           
                          autoAttachVarLabels = TRUE)

view_spss(radio,encoding = "cp1250")

labels.etykiety <- get_val_labels(radio)

labels.wartosci <- get_var_labels(radio)

radio <- set_val_labels(radio, labels.etykiety)

radio <- set_var_labels(radio, labels.wartosci)

# Zadanie 21

ocena <- radio[,3:26]
sjt.stackfrq(ocena,
             encoding='cp1250',
             alternateRowColors = TRUE,
             )
# Zadanie 22
sjt.stackfrq(ocena,
             encoding='cp1250', 
             showN = TRUE, 
             showTotalN = TRUE,
             alternateRowColors = TRUE)