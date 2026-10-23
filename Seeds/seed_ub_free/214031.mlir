module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-97.4899978> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<49> : tensor<7x3x8xi64>}> : () -> tensor<7x3x8xi64>
    %2 = "tosa.const"() <{values = dense<-104> : tensor<1x1x8xi64>}> : () -> tensor<1x1x8xi64>
    %3 = tosa.sigmoid %0 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.add %3, %3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %5 = tosa.rsqrt %4 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.minimum %1, %2 : (tensor<7x3x8xi64>, tensor<1x1x8xi64>) -> tensor<7x3x8xi64>
    %7 = tosa.bitwise_or %6, %6 : (tensor<7x3x8xi64>, tensor<7x3x8xi64>) -> tensor<7x3x8xi64>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %9 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %10 = tosa.negate %7, %8, %9 : (tensor<7x3x8xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<7x3x8xi64>
    %11 = tosa.reduce_min %10 {axis = 2 : i32} : (tensor<7x3x8xi64>) -> tensor<7x3x1xi64>
    %12 = tosa.add %11, %11 : (tensor<7x3x1xi64>, tensor<7x3x1xi64>) -> tensor<7x3x1xi64>
    %cast = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %12 : tensor<7x3x1xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

