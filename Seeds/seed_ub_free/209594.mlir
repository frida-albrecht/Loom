module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-194> : tensor<5xi32>}> : () -> tensor<5xi32>
    %1 = "tosa.const"() <{values = dense<27> : tensor<5xi32>}> : () -> tensor<5xi32>
    %2 = "tosa.const"() <{values = dense<5.241000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.maximum %0, %1 : (tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>
    %4 = tosa.exp %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %3 : tensor<5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

