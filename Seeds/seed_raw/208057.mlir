module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<44> : tensor<2x5xi64>}> : () -> tensor<2x5xi64>
    %1 = tosa.const_shape  {values = dense<3> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<2x5xi64>, !tosa.shape<2>) -> tensor<6x15xi64>
    %3 = tosa.const_shape  {values = dense<[2, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.tile %2, %3 : (tensor<6x15xi64>, !tosa.shape<2>) -> tensor<12x15xi64>
    %5 = tosa.argmax %4 {axis = 0 : i32} : (tensor<12x15xi64>) -> tensor<15xi32>
    %cast = tensor.cast %5 : tensor<15xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

