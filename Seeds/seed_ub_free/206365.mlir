module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<53> : tensor<4x2xi32>}> : () -> tensor<4x2xi32>
    %1 = "tosa.const"() <{values = dense<35> : tensor<4x1xi32>}> : () -> tensor<4x1xi32>
    %2 = tosa.minimum %0, %1 : (tensor<4x2xi32>, tensor<4x1xi32>) -> tensor<4x2xi32>
    %3 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %4 = tosa.transpose %2 {perms = array<i32: 0, 1>} : (tensor<4x2xi32>) -> tensor<4x2xi32>
    %cast = tensor.cast %4 : tensor<4x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

