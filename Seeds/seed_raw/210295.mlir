module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-15> : tensor<9xi16>}> : () -> tensor<9xi16>
    %1 = "tosa.const"() <{values = dense<117> : tensor<1x2xi32>}> : () -> tensor<1x2xi32>
    %2 = "tosa.const"() <{values = dense<-1.310000e+02> : tensor<7x2x10x3xf32>}> : () -> tensor<7x2x10x3xf32>
    %3 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = tosa.pad %0, %3, %4 : (tensor<9xi16>, !tosa.shape<2>, tensor<1xi16>) -> tensor<9xi16>
    %6 = tosa.argmax %5 {axis = 0 : i32} : (tensor<9xi16>) -> tensor<i32>
    %7 = tosa.log %2 : (tensor<7x2x10x3xf32>) -> tensor<7x2x10x3xf32>
    %8 = tosa.floor %7 : (tensor<7x2x10x3xf32>) -> tensor<7x2x10x3xf32>
    %cast = tensor.cast %6 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<7x2x10x3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

