module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<175> : tensor<5x1x9x1xi64>}> : () -> tensor<5x1x9x1xi64>
    %1 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<5x1x9x1xi64>) -> tensor<1x1x9x1xi64>
    %2 = tosa.const_shape  {values = dense<[3, 2, 3, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.tile %1, %2 : (tensor<1x1x9x1xi64>, !tosa.shape<4>) -> tensor<3x2x27x3xi64>
    %cast = tensor.cast %3 : tensor<3x2x27x3xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

