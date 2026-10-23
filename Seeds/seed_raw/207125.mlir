module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-125> : tensor<6x9xi16>}> : () -> tensor<6x9xi16>
    %1 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<6x9xi16>, !tosa.shape<2>) -> tensor<12x27xi16>
    %cast = tensor.cast %2 : tensor<12x27xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

