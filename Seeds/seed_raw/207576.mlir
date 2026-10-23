module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<68.4499969> : tensor<10x10xf32>}> : () -> tensor<10x10xf32>
    %1 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 1>} : (tensor<10x10xf32>) -> tensor<10x10xf32>
    %3 = tosa.reciprocal %2 : (tensor<10x10xf32>) -> tensor<10x10xf32>
    %4 = tosa.argmax %3 {axis = 1 : i32} : (tensor<10x10xf32>) -> tensor<10xi32>
    %cast = tensor.cast %4 : tensor<10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

