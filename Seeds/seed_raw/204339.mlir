module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-59> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-9.590000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<-2.753000e+01> : tensor<f32>}> : () -> tensor<f32>
    %4 = tosa.sub %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.abs %4 : (tensor<i32>) -> tensor<i32>
    %6 = tosa.logical_right_shift %5, %4 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %7 = tosa.pow %2, %3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %8 = tosa.logical_left_shift %6, %5 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

