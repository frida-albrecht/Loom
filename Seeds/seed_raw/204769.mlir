module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<84> : tensor<10x5x8xi64>}> : () -> tensor<10x5x8xi64>
    %1 = tosa.const_shape  {values = dense<[3, 3, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.tile %0, %1 : (tensor<10x5x8xi64>, !tosa.shape<3>) -> tensor<30x15x16xi64>
    %3 = tosa.const_shape  {values = dense<[72, 2, 2, 25]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.reshape %2, %3 : (tensor<30x15x16xi64>, !tosa.shape<4>) -> tensor<72x2x2x25xi64>
    %cast = tensor.cast %4 : tensor<72x2x2x25xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

