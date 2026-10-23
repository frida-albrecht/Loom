module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.483000e+01> : tensor<4x1xf32>}> : () -> tensor<4x1xf32>
    %1 = tosa.argmax %0 {axis = 1 : i32} : (tensor<4x1xf32>) -> tensor<4xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = tosa.transpose %1 {perms = array<i32: 0>} : (tensor<4xi32>) -> tensor<4xi32>
    %cast = tensor.cast %3 : tensor<4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

