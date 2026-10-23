module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.055300e+02> : tensor<1x7x6x2xf32>}> : () -> tensor<1x7x6x2xf32>
    %1 = "tosa.const"() <{values = dense<-17> : tensor<7x7x9x3xi64>}> : () -> tensor<7x7x9x3xi64>
    %2 = "tosa.const"() <{values = dense<-94> : tensor<1x7x1x1xi64>}> : () -> tensor<1x7x1x1xi64>
    %3 = tosa.reciprocal %0 : (tensor<1x7x6x2xf32>) -> tensor<1x7x6x2xf32>
    %4 = tosa.clamp %3 {max_val = 1.000000e+02 : f32, min_val = -5.600000e+01 : f32} : (tensor<1x7x6x2xf32>) -> tensor<1x7x6x2xf32>
    %5 = tosa.abs %4 : (tensor<1x7x6x2xf32>) -> tensor<1x7x6x2xf32>
    %6 = tosa.bitwise_xor %1, %2 : (tensor<7x7x9x3xi64>, tensor<1x7x1x1xi64>) -> tensor<7x7x9x3xi64>
    %7 = tosa.sigmoid %5 : (tensor<1x7x6x2xf32>) -> tensor<1x7x6x2xf32>
    %8 = tosa.bitwise_not %6 : (tensor<7x7x9x3xi64>) -> tensor<7x7x9x3xi64>
    %9 = tosa.pow %5, %4 : (tensor<1x7x6x2xf32>, tensor<1x7x6x2xf32>) -> tensor<1x7x6x2xf32>
    %cast = tensor.cast %7 : tensor<1x7x6x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<7x7x9x3xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %9 : tensor<1x7x6x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

