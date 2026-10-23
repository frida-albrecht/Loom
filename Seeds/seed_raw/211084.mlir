module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-28> : tensor<7x10x3x5xi32>}> : () -> tensor<7x10x3x5xi32>
    %1 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 3, 1, 2>} : (tensor<7x10x3x5xi32>) -> tensor<7x5x10x3xi32>
    %3 = tosa.logical_left_shift %2, %2 : (tensor<7x5x10x3xi32>, tensor<7x5x10x3xi32>) -> tensor<7x5x10x3xi32>
    %cast = tensor.cast %3 : tensor<7x5x10x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

