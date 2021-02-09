# mod_avg
Model averaging function 

Hey guys! 

I created a function for model averaging called `mod_avg()` that brings together functionality from `AICcmodavg` and `MuMIn`, plus some very helpful proprietary functions. If you give it a list of models using `mods_set = your_mods`, it will return an AIC model selection table with formulas from your models pasted into the model names (which is _really_ helpful) to your environment, but if you prefer tables in the form of a .CSV, .RDS, you may indicate that using arguments `aic_csv = T` or `aic_rds = T` (by default, it returns the object to your environment). The other main function is calculating model-averaged predictions of fitted values, which can also be printed to a .CSV and .RDS using `preds_csv = T` and `preds_rds = T`, or just also loaded into your environment by default. You can also ask it to subset model averaged selection tables or predictions by delta AIC simply by specifying a value in the `delta_aic` argument. For instance, `delta_aic = 6` will return only models or predictions from models that are < 6 delta AIC from the top model (default is subsetted by `Inf`, and will therefore return tables/predictions from all models). 

So, I think it's pretty darn useful! Let me know what you think. 

However, I've only coded it to work with `glm`, `glmm`, `lm`, and `lmm` models, but I will expand it for more soon.

If you'd like to use it, you may load it directly from here to your environment using the following code:
```
devtools::source_url("https://raw.githubusercontent.com/slamander/mod_avg/master/mod_avg.R")
```

Here's an example of it at work:
```
> mods1_output <- mod_avg(mods_set = mods1, 
+                         predict = T,
+                         delta_aic = 12,
+                         aic_csv = T)
> mods1_output$aic_tab %>%
+   glimpse()
Rows: 4
Columns: 8
$ Modnames   <chr> "Height_A ~ Species * Pair * Novel * Type + ADR_A + Time + Code + RH + Temp_F + (Time | Frog_ID_A)", "Height_A ~ Species * Pair * Novel * Type + WCP_A + T...
$ K          <dbl> 36, 36, 37, 62
$ AICc       <dbl> 5519.285, 5519.863, 5521.356, 5530.328
$ Delta_AICc <dbl> 0.0000000, 0.5779103, 2.0705852, 11.0428830
$ ModelLik   <dbl> 1.000000000, 0.749045801, 0.355122449, 0.004000078
$ AICcWt     <dbl> 0.474335046, 0.355298675, 0.168447023, 0.001897377
$ LL         <dbl> -2723.006, -2723.295, -2723.006, -2701.274
$ Cum.Wt     <dbl> 0.4743350, 0.8296337, 0.9980807, 0.9999781
> mods1_output$model_preds %>% head()
         1          2          3          4          5          6 
-0.6691745  0.2905654  0.3479291  0.6855289  0.4481183  0.7189391 
If you get the chance to give it a try, I'm sure it's loaded with bugs--so let me know! 
```

Currently I have a lot of items on the to do list to improve this function, but above all will be adding helpful error messages.. 

Best, 

-Alex. 