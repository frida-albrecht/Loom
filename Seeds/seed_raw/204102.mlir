module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<45> : tensor<9xi16>}> : () -> tensor<9xi16>
    %1 = "tosa.const"() <{values = dense<-1.253300e+02> : tensor<4x6x1xf32>}> : () -> tensor<4x6x1xf32>
    %2 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %3 = tosa.tile %0, %2 : (tensor<9xi16>, !tosa.shape<1>) -> tensor<27xi16>
    %4 = tosa.reciprocal %1 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %cast = tensor.cast %3 : tensor<27xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %4 : tensor<4x6x1xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

