module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-31> : tensor<3x8xi64>}> : () -> tensor<3x8xi64>
    %1 = "tosa.const"() <{values = dense<151> : tensor<3x1xi64>}> : () -> tensor<3x1xi64>
    %2 = "tosa.const"() <{values = dense<-1.672000e+02> : tensor<3xf32>}> : () -> tensor<3xf32>
    %3 = tosa.maximum %0, %1 : (tensor<3x8xi64>, tensor<3x1xi64>) -> tensor<3x8xi64>
    %4 = tosa.sub %3, %3 : (tensor<3x8xi64>, tensor<3x8xi64>) -> tensor<3x8xi64>
    %5 = tosa.log %2 : (tensor<3xf32>) -> tensor<3xf32>
    %6 = tosa.ceil %5 : (tensor<3xf32>) -> tensor<3xf32>
    %7 = tosa.sub %6, %6 : (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
    %8 = tosa.reciprocal %7 : (tensor<3xf32>) -> tensor<3xf32>
    %9 = tosa.reverse %5 {axis = 0 : i32} : (tensor<3xf32>) -> tensor<3xf32>
    %10 = tosa.sigmoid %9 : (tensor<3xf32>) -> tensor<3xf32>
    %11 = tosa.logical_left_shift %3, %3 : (tensor<3x8xi64>, tensor<3x8xi64>) -> tensor<3x8xi64>
    %12 = tosa.concat %10, %8 {axis = 0 : i32} : (tensor<3xf32>, tensor<3xf32>) -> tensor<6xf32>
    %13 = tosa.sigmoid %8 : (tensor<3xf32>) -> tensor<3xf32>
    %cast = tensor.cast %4 : tensor<3x8xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %11 : tensor<3x8xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %12 : tensor<6xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %13 : tensor<3xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}

