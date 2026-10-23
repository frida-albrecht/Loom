module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<56> : tensor<4xi16>}> : () -> tensor<4xi16>
    %1 = tosa.const_shape  {values = dense<0> : tensor<1xindex>} : () -> !tosa.shape<1>
    %2 = tosa.const_shape  {values = dense<4> : tensor<1xindex>} : () -> !tosa.shape<1>
    %3 = tosa.slice %0, %1, %2 : (tensor<4xi16>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<4xi16>
    %cast = tensor.cast %3 : tensor<4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

