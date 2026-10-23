module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.717000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<189> : tensor<10x5xi32>}> : () -> tensor<10x5xi32>
    %2 = "tosa.const"() <{values = dense<-94> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %3 = tosa.sigmoid %0 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.sigmoid %3 : (tensor<f32>) -> tensor<f32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %clamped_lower = tosa.maximum %2, %c0 : (tensor<1x1xi32>, tensor<1x1xi32>) -> tensor<1x1xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %clamped_shift = tosa.minimum %clamped_lower, %c31 : (tensor<1x1xi32>, tensor<1x1xi32>) -> tensor<1x1xi32>
    %5 = tosa.logical_right_shift %1, %clamped_shift : (tensor<10x5xi32>, tensor<1x1xi32>) -> tensor<10x5xi32>
    %6 = tosa.bitwise_not %5 : (tensor<10x5xi32>) -> tensor<10x5xi32>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<10x5xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}