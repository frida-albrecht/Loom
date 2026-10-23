module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %cst = arith.constant 3.474000e+01 : f64
    %cst_0 = arith.constant 82.019999999999996 : f64
    %c-127_i32 = arith.constant -127 : i32
    %0 = "tosa.const"() <{values = dense<-3.775000e+01> : tensor<16x32xf32>}> : () -> tensor<16x32xf32>
    %1 = linalg.fill_rng_2d ins(%cst, %cst_0, %c-127_i32 : f64, f64, i32) outs(%0 : tensor<16x32xf32>) -> tensor<16x32xf32>
    %cast = tensor.cast %1 : tensor<16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

