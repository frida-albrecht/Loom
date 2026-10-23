module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.606000e+01> : tensor<5x1x8x9xf32>}> : () -> tensor<5x1x8x9xf32>
    %1 = tosa.ceil %0 : (tensor<5x1x8x9xf32>) -> tensor<5x1x8x9xf32>
    %2 = tosa.reciprocal %1 : (tensor<5x1x8x9xf32>) -> tensor<5x1x8x9xf32>
    %3 = tosa.argmax %2 {axis = 1 : i32} : (tensor<5x1x8x9xf32>) -> tensor<5x8x9xi32>
    %cast = tensor.cast %3 : tensor<5x8x9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

