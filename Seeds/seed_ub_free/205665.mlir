module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2> : tensor<8x10x9xi8>}> : () -> tensor<8x10x9xi8>
    %1 = "tosa.const"() <{values = dense<16> : tensor<1x1x1xi8>}> : () -> tensor<1x1x1xi8>
    %2 = "tosa.const"() <{values = dense<-1.690600e+02> : tensor<5x1xf32>}> : () -> tensor<5x1xf32>
    %3 = tosa.sub %0, %1 : (tensor<8x10x9xi8>, tensor<1x1x1xi8>) -> tensor<8x10x9xi8>
    %4 = tosa.floor %2 : (tensor<5x1xf32>) -> tensor<5x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<8x10x9xi8>}> : () -> tensor<8x10x9xi8>
    %c1 = "tosa.const"() <{values = dense<7> : tensor<8x10x9xi8>}> : () -> tensor<8x10x9xi8>
    %a0 = tosa.maximum %3, %c0 : (tensor<8x10x9xi8>, tensor<8x10x9xi8>) -> tensor<8x10x9xi8>
    %a1 = tosa.minimum %a0, %c1 : (tensor<8x10x9xi8>, tensor<8x10x9xi8>) -> tensor<8x10x9xi8>
    %5 = tosa.logical_right_shift %3, %a1 : (tensor<8x10x9xi8>, tensor<8x10x9xi8>) -> tensor<8x10x9xi8>
    %cast = tensor.cast %4 : tensor<5x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<8x10x9xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}