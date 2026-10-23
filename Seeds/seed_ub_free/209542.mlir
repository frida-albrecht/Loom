module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<105> : tensor<9x10xi64>}> : () -> tensor<9x10xi64>
    %1 = tosa.reverse %0 {axis = 1 : i32} : (tensor<9x10xi64>) -> tensor<9x10xi64>
    %2 = tosa.const_shape  {values = dense<[1, 5]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.const_shape  {values = dense<[8, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.slice %1, %2, %3 : (tensor<9x10xi64>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<8x1xi64>
    %cast = tensor.cast %4 : tensor<8x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

