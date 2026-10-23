module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.572300e+02> : tensor<9x3xf32>}> : () -> tensor<9x3xf32>
    %1 = "tosa.const"() <{values = dense<-117> : tensor<2x1x2xi64>}> : () -> tensor<2x1x2xi64>
    %2 = "tosa.const"() <{values = dense<-1> : tensor<1x1x1xi64>}> : () -> tensor<1x1x1xi64>
    %3 = tosa.rsqrt %0 : (tensor<9x3xf32>) -> tensor<9x3xf32>
    %4 = tosa.reciprocal %3 : (tensor<9x3xf32>) -> tensor<9x3xf32>
    %5 = tosa.ceil %4 : (tensor<9x3xf32>) -> tensor<9x3xf32>
    %6 = tosa.bitwise_or %1, %2 : (tensor<2x1x2xi64>, tensor<1x1x1xi64>) -> tensor<2x1x2xi64>
    %7 = tosa.identity %5 : (tensor<9x3xf32>) -> tensor<9x3xf32>
    %8 = tosa.bitwise_xor %6, %6 : (tensor<2x1x2xi64>, tensor<2x1x2xi64>) -> tensor<2x1x2xi64>
    %9 = tosa.clamp %6 {max_val = 63 : i64, min_val = 1 : i64} : (tensor<2x1x2xi64>) -> tensor<2x1x2xi64>
    %10 = tosa.pow %4, %4 : (tensor<9x3xf32>, tensor<9x3xf32>) -> tensor<9x3xf32>
    %11 = tosa.clz %9 : (tensor<2x1x2xi64>) -> tensor<2x1x2xi64>
    %cast = tensor.cast %7 : tensor<9x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<2x1x2xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %10 : tensor<9x3xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %11 : tensor<2x1x2xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_2) : (tensor<*xi64>) -> ()
    return
  }
}

