context("Tests the pre functions")

test_that("Get previous results with airquality and pre function", {
  set.seed(42)
  #####
  # With learning rate
  airq.ens <- pre(Ozone ~ ., data=airquality, ntrees = 10)
  
  # We remove some of the data to decrease the size
  airq.ens <- airq.ens[!names(airq.ens) %in%  c(
    "classify", "formula", "orig_data", "modmat_formula", "modmat", "data")]
  airq.ens$glmnet.fit <- airq.ens$glmnet.fit["glmnet.fit"]
  # save_to_test(airq.ens, "airquality_w_pre")
  expect_equal(airq.ens, read_to_test("airquality_w_pre"), tolerance = 1.490116e-08)
  
  #####
  # Without learning rate
  airq.ens <- pre(Ozone ~ ., data=airquality, learnrate = 0, ntrees = 10)
  
  airq.ens <- airq.ens[!names(airq.ens) %in%  c(
    "classify", "formula", "orig_data", "modmat_formula", "modmat", "data")]
  airq.ens$glmnet.fit <- airq.ens$glmnet.fit["glmnet.fit"]
  # save_to_test(airq.ens, "airquality_w_pre_without_LR")
  expect_equal(airq.ens, read_to_test("airquality_w_pre_without_LR"), tolerance = 1.490116e-08)
  
  #####
  # Works only with rules
  set.seed(42)
  airq.ens <- pre(Ozone ~ ., data = airquality, type="rules", ntrees = 10)
  
  airq.ens <- airq.ens[!names(airq.ens) %in%  c(
    "classify", "formula", "orig_data", "modmat_formula", "modmat", "data")]
  airq.ens$glmnet.fit <- airq.ens$glmnet.fit["glmnet.fit"]
  # save_to_test(airq.ens, "airquality_w_pre_without_linear_terms")
  expect_equal(airq.ens, read_to_test("airquality_w_pre_without_linear_terms"), tolerance = 1.49e-08)
})

test_that("Get previous results with PimaIndiansDiabetes and pre function", {
  #####
  # Without learning rate
  set.seed(7385056)
  fit <- pre(diabetes ~ ., data = PimaIndiansDiabetes, ntrees = 10, maxdepth = 3)
  
  # We remove some of the data to decrease the size
  fit <- fit[names(fit) %in%  c("rules", "glmnet.fit")]
  fit$glmnet.fit <- fit$glmnet.fit["glmnet.fit"]
  fit$glmnet.fit$glmnet.fit <- fit$glmnet.fit$glmnet.fit["beta"]
  fit$glmnet.fit$glmnet.fit[["beta"]] <- head(fit$glmnet.fit$glmnet.fit$beta@x, 200)
  fit$rules <- as.matrix(fit$rules)
  # save_to_test(fit, "PimaIndiansDiabetes_w_pre_no_LR")
  expect_equal(fit, read_to_test("PimaIndiansDiabetes_w_pre_no_LR"), tolerance = 1.490116e-08)
  
  #####
  # With learning rate
  set.seed(4989935)
  fit <- pre(diabetes ~ ., data = PimaIndiansDiabetes, learnrate = .01,
             ntrees = 10, maxdepth = 3)
  
  # We remove some of the data to decrease the size
  fit <- fit[!names(fit) %in%  c(
    "classify", "formula", "orig_data", "modmat_formula", "modmat", "data", "rulevars")]
  fit$glmnet.fit <- fit$glmnet.fit["glmnet.fit"]
  # save_to_test(fit, "PimaIndiansDiabetes_w_pre_LR")
  expect_equal(fit, read_to_test("PimaIndiansDiabetes_w_pre_LR"), tolerance = 1.490116e-08)
})

test_that("Pre gives previous results on BostonHousing", {
  set.seed(10681519)
  fit <- pre(medv ~ ., BostonHousing, ntree = 10)
  
  fit <- fit[!names(fit) %in%  c(
    "classify", "formula", "orig_data", "modmat_formula", "modmat", "data", "rulevars")]
  fit$glmnet.fit <- fit$glmnet.fit["glmnet.fit"]
  # save_to_test(fit, "BostonHousing_n_pre")
  expect_equal(fit, read_to_test("BostonHousing_n_pre"), tolerance = 1.49e-08)
})