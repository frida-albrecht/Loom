module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-139> : tensor<4xi64>}> : () -> tensor<4xi64>
    %1 = "tosa.const"() <{values = dense<-1.285000e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %2 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<4xi64>) -> tensor<1xi64>
    %3 = tosa.identity %2 : (tensor<1xi64>) -> tensor<1xi64>
    %4 = tosa.reciprocal %1 : (tensor<2xf32>) -> tensor<2xf32>
    %5 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<1xi64>) -> tensor<1xi64>
    %6 = tosa.identity %5 : (tensor<1xi64>) -> tensor<1xi64>
    %7 = tosa.reverse %4 {axis = 0 : i32} : (tensor<2xf32>) -> tensor<2xf32>
    %cast = tensor.cast %6 : tensor<1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<2xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

