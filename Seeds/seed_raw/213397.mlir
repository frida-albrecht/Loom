module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<4x5x3xi8>}> : () -> tensor<4x5x3xi8>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<4x5x3xi8>) -> tensor<5x3xi32>
    %2 = tosa.const_shape  {values = dense<[3, 5, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.reshape %1, %2 : (tensor<5x3xi32>, !tosa.shape<3>) -> tensor<3x5x1xi32>
    %cast = tensor.cast %3 : tensor<3x5x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

