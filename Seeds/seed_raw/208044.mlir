module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<152> : tensor<7x5xi32>}> : () -> tensor<7x5xi32>
    %1 = "tosa.const"() <{values = dense<156> : tensor<7x5xi32>}> : () -> tensor<7x5xi32>
    %2 = "tosa.const"() <{values = dense<4.424000e+01> : tensor<9x7x7xf32>}> : () -> tensor<9x7x7xf32>
    %3 = tosa.bitwise_xor %0, %1 : (tensor<7x5xi32>, tensor<7x5xi32>) -> tensor<7x5xi32>
    %4 = tosa.reciprocal %2 : (tensor<9x7x7xf32>) -> tensor<9x7x7xf32>
    %5 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<7x5xi32>) -> tensor<1x5xi32>
    %cast = tensor.cast %4 : tensor<9x7x7xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<1x5xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

