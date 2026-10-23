module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<114> : tensor<2x4x7x5xi32>}> : () -> tensor<2x4x7x5xi32>
    %1 = "tosa.const"() <{values = dense<-125> : tensor<1x1x1x1xi32>}> : () -> tensor<1x1x1x1xi32>
    %2 = "tosa.const"() <{values = dense<5.677000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<1.707900e+02> : tensor<f32>}> : () -> tensor<f32>
    %4 = tosa.maximum %0, %1 : (tensor<2x4x7x5xi32>, tensor<1x1x1x1xi32>) -> tensor<2x4x7x5xi32>
    %5 = tosa.pow %2, %3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %6 = tosa.log %5 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.reduce_product %4 {axis = 1 : i32} : (tensor<2x4x7x5xi32>) -> tensor<2x1x7x5xi32>
    %cast = tensor.cast %6 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<2x1x7x5xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

