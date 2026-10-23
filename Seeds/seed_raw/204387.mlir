module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<65> : tensor<9x2x9x2xi64>}> : () -> tensor<9x2x9x2xi64>
    %1 = tosa.argmax %0 {axis = 3 : i32} : (tensor<9x2x9x2xi64>) -> tensor<9x2x9xi32>
    %2 = tosa.const_shape  {values = dense<[54, 3, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.reshape %1, %2 : (tensor<9x2x9xi32>, !tosa.shape<3>) -> tensor<54x3x1xi32>
    %cast = tensor.cast %3 : tensor<54x3x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

