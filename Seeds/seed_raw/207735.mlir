module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<85> : tensor<5x9x3xi64>}> : () -> tensor<5x9x3xi64>
    %1 = tosa.const_shape  {values = dense<135> : tensor<1xindex>} : () -> !tosa.shape<1>
    %2 = tosa.reshape %0, %1 : (tensor<5x9x3xi64>, !tosa.shape<1>) -> tensor<135xi64>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<135xi64>) -> tensor<i32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

