module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-163> : tensor<2x10x6xi16>}> : () -> tensor<2x10x6xi16>
    %1 = "tosa.const"() <{values = dense<57> : tensor<2x6x1xi16>}> : () -> tensor<2x6x1xi16>
    %2 = "tosa.const"() <{values = dense<-1.686700e+02> : tensor<10xf32>}> : () -> tensor<10xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<2x10x6xi16>, tensor<2x6x1xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<2x10x1xi16>
    %6 = tosa.exp %2 : (tensor<10xf32>) -> tensor<10xf32>
    %7 = tosa.minimum %6, %6 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %cast = tensor.cast %5 : tensor<2x10x1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<10xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

