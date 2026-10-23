module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<9x9xi1>}> : () -> tensor<9x9xi1>
    %1 = tosa.reduce_all %0 {axis = 1 : i32} : (tensor<9x9xi1>) -> tensor<9x1xi1>
    %2 = tosa.argmax %1 {axis = 0 : i32} : (tensor<9x1xi1>) -> tensor<1xi32>
    %3 = tosa.add %2, %2 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %4 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = tosa.reshape %3, %4 : (tensor<1xi32>, !tosa.shape<2>) -> tensor<1x1xi32>
    %6 = tosa.bitwise_not %5 : (tensor<1x1xi32>) -> tensor<1x1xi32>
    %cast = tensor.cast %6 : tensor<1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

