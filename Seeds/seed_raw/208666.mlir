module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<4x6xi32>}> : () -> tensor<4x6xi32>
    %1 = "tosa.const"() <{values = dense<-1.200000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.reduce_product %0 {axis = 1 : i32} : (tensor<4x6xi32>) -> tensor<4x1xi32>
    %3 = tosa.sigmoid %1 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %2 : tensor<4x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

