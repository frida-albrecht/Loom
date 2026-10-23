module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<10> : tensor<9x7xi32>}> : () -> tensor<9x7xi32>
    %1 = tosa.const_shape  {values = dense<[3, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<9x7xi32>, !tosa.shape<2>) -> tensor<27x14xi32>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<27x14xi32>) -> tensor<14xi32>
    %cast = tensor.cast %3 : tensor<14xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

