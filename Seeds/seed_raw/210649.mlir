module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.815000e+01> : tensor<1x1x6x2xf32>}> : () -> tensor<1x1x6x2xf32>
    %1 = tosa.sigmoid %0 : (tensor<1x1x6x2xf32>) -> tensor<1x1x6x2xf32>
    %2 = tosa.argmax %1 {axis = 2 : i32} : (tensor<1x1x6x2xf32>) -> tensor<1x1x2xi32>
    %cast = tensor.cast %2 : tensor<1x1x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

