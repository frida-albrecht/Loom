module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.822300e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<f32>, !tosa.shape<4>) -> tensor<1x1x1x1xf32>
    %3 = "tosa.const"() <{values = dense<[0, 1, 2, 3]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %4 = tosa.transpose %2 {perms = array<i32: 0, 1, 2, 3>} : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %cast = tensor.cast %4 : tensor<1x1x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

