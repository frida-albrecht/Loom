module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.838500e+02> : tensor<8x2x2xf32>}> : () -> tensor<8x2x2xf32>
    %1 = "tosa.const"() <{values = dense<-71> : tensor<5x8x7x9xi32>}> : () -> tensor<5x8x7x9xi32>
    %2 = "tosa.const"() <{values = dense<-133> : tensor<5x1x1x1xi32>}> : () -> tensor<5x1x1x1xi32>
    %3 = tosa.floor %0 : (tensor<8x2x2xf32>) -> tensor<8x2x2xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<5x8x7x9xi32>, tensor<5x1x1x1xi32>) -> tensor<5x8x7x9xi32>
    %cast = tensor.cast %3 : tensor<8x2x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<5x8x7x9xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

