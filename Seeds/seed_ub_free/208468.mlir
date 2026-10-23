module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.515600e+02> : tensor<4x5x2x1xf32>}> : () -> tensor<4x5x2x1xf32>
    %1 = tosa.const_shape  {values = dense<[2, 3, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<4x5x2x1xf32>, !tosa.shape<4>) -> tensor<8x15x2x1xf32>
    %3 = tosa.concat %2, %2 {axis = 3 : i32} : (tensor<8x15x2x1xf32>, tensor<8x15x2x1xf32>) -> tensor<8x15x2x2xf32>
    %cast = tensor.cast %3 : tensor<8x15x2x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

