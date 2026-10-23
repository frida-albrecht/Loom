module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-67> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-170> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-1.605800e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<-1.141700e+02> : tensor<f32>}> : () -> tensor<f32>
    %4 = tosa.intdiv %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.clz %4 : (tensor<i32>) -> tensor<i32>
    %6 = tosa.bitwise_and %5, %5 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %7 = tosa.logical_right_shift %6, %4 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %a0 = tosa.abs %2 : (tensor<f32>) -> tensor<f32>
    %8 = tosa.pow %a0, %3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %9 = tosa.bitwise_and %7, %7 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %8 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}