module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.068000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-73> : tensor<6xi32>}> : () -> tensor<6xi32>
    %2 = tosa.exp %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reduce_sum %1 {axis = 0 : i32} : (tensor<6xi32>) -> tensor<1xi32>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %3 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

