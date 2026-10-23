module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<5xi1>}> : () -> tensor<5xi1>
    %1 = "tosa.const"() <{values = dense<true> : tensor<5xi1>}> : () -> tensor<5xi1>
    %2 = tosa.logical_or %0, %1 : (tensor<5xi1>, tensor<5xi1>) -> tensor<5xi1>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<5xi1>) -> tensor<i32>
    %4 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = tosa.reshape %3, %4 : (tensor<i32>, !tosa.shape<2>) -> tensor<1x1xi32>
    %cast = tensor.cast %5 : tensor<1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

